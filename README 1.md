# ServerForge - Improved build
This build completes placeholder scripts and provides a minimal working prototype.

How to run (Linux):
1. Extract and cd into project.
2. Run `./main.sh` to start web UI or `./main.sh --cli` for CLI.
3. Use `./modules/server_manager.sh start` to run a local simple HTTP server on port 8000.
4. Use `./tools/integrity_check.py --verify` to generate or verify manifest.

Files updated:
- ui/webapp.py
- serverforge.py
- tools/integrity_check.py
- modules/* (server_manager, auto_update, monitor, db_manager, security, sandbox)
- installers/*

Notes:
This is a minimal safe implementation. Adjust paths and behavior for production. Use sudo for installer operations.
