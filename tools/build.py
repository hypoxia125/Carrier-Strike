import subprocess
import sys
import os

def find_project_root():
    """Find project root by looking for 'Carrier-Strike' directory"""
    current_dir = os.path.abspath(os.path.dirname(__file__))
    target_dir = "Carrier-Strike"
    
    # Search upward through directories
    while current_dir != os.path.dirname(current_dir):  # Stop at filesystem root
        if os.path.basename(current_dir) == target_dir:
            return current_dir
        current_dir = os.path.dirname(current_dir)
    raise FileNotFoundError(f"Could not find project root ('{target_dir}' directory not found)")

def get_user_choice():
    """Prompt user to select dev, build, or release mode"""
    print("\nSelect HEMTT mode:")
    print("1. dev")
    print("2. build")
    print("3. release")
    
    while True:
        choice = input("Enter your choice (1-3): ").strip()
        if choice == "1":
            return "dev"
        elif choice == "2":
            return "build"
        elif choice == "3":
            return "release"
        print("Invalid choice. Please enter 1, 2, or 3.")
        
def run_build_commands():
    mode = get_user_choice()
    final_cmd = f"hemtt {mode}"
        
    commands = [
        "python tools/buildStringtables.py",
        "hemtt utils fnl",
        "hemtt ln sort",
        final_cmd
    ]
    
    # Check if we're running in PowerShell already
    if 'powershell' in os.environ.get('SHELL', '').lower():
        ps_command = "& {" + "; ".join(commands) + "}"
    else:
        # Format the command for PowerShell
        ps_command = f"powershell -Command \"{'; '.join(commands)}\""
    
    try:
        project_root = find_project_root()
        print(f"Found project root at: {project_root}")
        os.chdir(project_root)        
        
        print("Running commands...")
        result = subprocess.run(
            ps_command,
            shell=True,
            check=True,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        print("HEMTT commands completed successfully")
        print(result.stdout)
        return True
    
    except FileNotFoundError as e:
        print(f"Error: {e}", file=sys.stderr)
        return False
    
    except subprocess.CalledProcessError as e:
        print("Error running HEMTT commands:")
        print(e.stderr)
        return False

if __name__ == "__main__":
    if not run_build_commands():
        sys.exit(1)