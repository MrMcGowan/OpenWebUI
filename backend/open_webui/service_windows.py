"""
Open WebUI Windows Service Wrapper
Enables Open WebUI to run as a Windows service on Windows Server 2022
"""

import sys
import os
import time
import subprocess
import win32serviceutil
import win32service
import win32event
import servicemanager
import socket
from pathlib import Path


class OpenWebUIService(win32serviceutil.ServiceFramework):
    _svc_name_ = "OpenWebUIService"
    _svc_display_name_ = "Open WebUI Service"
    _svc_description_ = "Open WebUI - Self-hosted AI Platform for Windows Server 2022"

    def __init__(self, args):
        win32serviceutil.ServiceFramework.__init__(self, args)
        self.stop_event = win32event.CreateEvent(None, 0, 0, None)
        self.process = None
        socket.setdefaulttimeout(60)

        # Get the service directory
        if getattr(sys, 'frozen', False):
            self.app_dir = Path(sys.executable).parent
        else:
            self.app_dir = Path(__file__).parent

        # Set up paths
        self.data_dir = self.app_dir / 'data'
        self.log_dir = self.app_dir / 'logs'

        # Create directories if they don't exist
        self.data_dir.mkdir(exist_ok=True)
        self.log_dir.mkdir(exist_ok=True)

    def SvcStop(self):
        """Called when the service is stopped"""
        self.ReportServiceStatus(win32service.SERVICE_STOP_PENDING)
        win32event.SetEvent(self.stop_event)

        # Terminate the subprocess
        if self.process:
            try:
                self.process.terminate()
                self.process.wait(timeout=10)
            except:
                self.process.kill()

    def SvcDoRun(self):
        """Called when the service is started"""
        servicemanager.LogMsg(
            servicemanager.EVENTLOG_INFORMATION_TYPE,
            servicemanager.PYS_SERVICE_STARTED,
            (self._svc_name_, '')
        )
        self.main()

    def main(self):
        """Main service loop"""
        try:
            # Set up environment
            os.chdir(str(self.app_dir))

            # Load environment variables from .env file
            env_file = self.data_dir / '.env'
            env_vars = os.environ.copy()

            if env_file.exists():
                with open(env_file, 'r') as f:
                    for line in f:
                        line = line.strip()
                        if line and not line.startswith('#') and '=' in line:
                            key, value = line.split('=', 1)
                            env_vars[key.strip()] = value.strip()

            # Set default environment variables
            env_vars.setdefault('WEBUI_HOST', '0.0.0.0')
            env_vars.setdefault('WEBUI_PORT', '8080')
            env_vars.setdefault('DATA_DIR', str(self.data_dir))

            # Log file paths
            stdout_log = self.log_dir / 'openwebui_stdout.log'
            stderr_log = self.log_dir / 'openwebui_stderr.log'

            # Start Open WebUI process
            with open(stdout_log, 'a') as out, open(stderr_log, 'a') as err:
                # If running as frozen executable, use the main.py from the bundle
                if getattr(sys, 'frozen', False):
                    python_exe = sys.executable
                    main_script = str(self.app_dir / 'open_webui' / 'main.py')
                else:
                    python_exe = sys.executable
                    main_script = str(self.app_dir / 'backend' / 'open_webui' / 'main.py')

                cmd = [python_exe, '-m', 'uvicorn', 'open_webui.main:app',
                       '--host', env_vars['WEBUI_HOST'],
                       '--port', env_vars['WEBUI_PORT'],
                       '--forwarded-allow-ips', '*']

                servicemanager.LogInfoMsg(f"Starting Open WebUI: {' '.join(cmd)}")

                self.process = subprocess.Popen(
                    cmd,
                    stdout=out,
                    stderr=err,
                    env=env_vars,
                    cwd=str(self.app_dir)
                )

            # Wait for stop signal
            while True:
                rc = win32event.WaitForSingleObject(self.stop_event, 5000)
                if rc == win32event.WAIT_OBJECT_0:
                    # Stop signal received
                    break

                # Check if process is still running
                if self.process.poll() is not None:
                    servicemanager.LogErrorMsg("Open WebUI process terminated unexpectedly")
                    break

        except Exception as e:
            servicemanager.LogErrorMsg(f"Error in service main loop: {str(e)}")
            raise


if __name__ == '__main__':
    if len(sys.argv) == 1:
        servicemanager.Initialize()
        servicemanager.PrepareToHostSingle(OpenWebUIService)
        servicemanager.StartServiceCtrlDispatcher()
    else:
        win32serviceutil.HandleCommandLine(OpenWebUIService)

