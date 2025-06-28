import re
import yaml
import shutil
from pathlib import Path

def load_replacement_map(yaml_file):
    """Load all replacement maps from YAML file."""
    with open(yaml_file, 'r') as f:
        return yaml.safe_load(f)

def replace_in_text(text, replacement_map):
    """Replace strings in text based on the replacement map."""
    keys = sorted(replacement_map.keys(), key=len, reverse=True)
    for key in keys:
        replacement = replacement_map[key]
        pattern = r'\b' + re.escape(key) + r'\b'
        text = re.sub(pattern, replacement, text)
    return text

def process_file(file_path, replacement_map, backup=True):
    """Modify file in-place with replacements."""
    if backup:
        backup_path = file_path.with_suffix(file_path.suffix + '.bak')
        shutil.copy2(file_path, backup_path)
    
    with open(file_path, 'r') as f:
        content = f.read()
    
    new_content = replace_in_text(content, replacement_map)
    
    with open(file_path, 'w') as f:
        f.write(new_content)

def main():
    # Configuration
    yaml_file = Path("cup.yaml")
    if not yaml_file.exists():
        print(f"Error: {yaml_file} not found!")
        return

    # Load all replacement maps first
    all_maps = load_replacement_map(yaml_file)
    
    # Show available maps with numbering
    print("\nAvailable replacement maps:")
    for i, map_name in enumerate(all_maps.keys(), 1):
        print(f"{i}. {map_name}")
    
    # Get map selection
    while True:
        try:
            selection = input("\nSelect map (number or name): ").strip()
            if selection.isdigit():
                selection = list(all_maps.keys())[int(selection)-1]
            if selection in all_maps:
                selected_map = selection
                break
            print("Invalid selection! Try again.")
        except (ValueError, IndexError):
            print("Invalid number! Try again.")

    # Get direction
    direction = input("Direction? [f]orward or [r]everse: ").strip().lower()
    while direction not in ('f', 'r'):
        direction = input("Must be 'f' or 'r': ").strip().lower()

    # Get file path
    while True:
        input_file = input("\nEnter file path to modify: ").strip()
        input_path = Path(input_file)
        if input_path.exists():
            break
        print(f"Error: {input_file} not found!")

    # Process file
    replacement_map = (
        all_maps[selected_map] if direction == 'f' 
        else {v: k for k, v in all_maps[selected_map].items() if v}
    )
    
    try:
        process_file(input_path, replacement_map)
        print(f"\nSuccess! Modified {input_file}")
        print(f"Backup saved to {input_path.with_suffix(input_path.suffix + '.bak')}")
    except Exception as e:
        print(f"\nError: {e}")

if __name__ == "__main__":
    print("=== String Replacement Tool ===")
    main()