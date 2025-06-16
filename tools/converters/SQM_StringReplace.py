import json
import sys

def load_config(config_path):
    with open(config_path, 'r') as f:
        return json.load(f)["replacements"]

def replace_in_file(file_path, replacements):
    with open(file_path, 'r') as f:
        content = f.read()
    
    for old, new in replacements.items():
        content = content.replace(old, new)
    
    with open(file_path, 'w') as f:
        f.write(content)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py <config.json> <target_file>")
        sys.exit(1)
    
    config_path = sys.argv[1]
    target_file = sys.argv[2]
    
    try:
        replacements = load_config(config_path)
        replace_in_file(target_file, replacements)
        print("Done!")
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)