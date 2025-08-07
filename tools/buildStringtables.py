import os
import sys
import subprocess
import pandas as pd
from xml.etree.ElementTree import Element, SubElement, tostring
from xml.dom.minidom import parseString

def install_dependencies():
    required = {
        "pandas": "pandas",
        "odfpy": "odfpy",
    }
    missing = []
    for package, import_name in required.items():
        try:
            __import__(import_name)
        except ImportError:
            missing.append(package)
    
    if missing:
        print(f"Installing missing dependencies: {', '.join(missing)}")
        try:
            subprocess.check_call([
                sys.executable, 
                "-m", "pip", "install", 
                *missing
            ], stdout=subprocess.DEVNULL)
        except subprocess.CalledProcessError:
            print("Failed to install dependencies. Please run manually:")
            print(f"  {sys.executable} -m pip install {' '.join(missing)}")
            sys.exit(1)
        
def create_empty_xml(filepath):
    """Create an empty XML file with basic structure"""
    project = Element("Project", name="CarrierStrike")
    package = SubElement(project, "Package", name="UI")
    SubElement(package, "Container", name="UI")
    
    xml_str = tostring(project, encoding="utf-8", xml_declaration=True)
    dom = parseString(xml_str)
    pretty_xml = dom.toprettyxml(indent="\t", encoding="utf-8")
    
    os.makedirs(os.path.dirname(filepath), exist_ok=True)
    with open(filepath, "wb") as f:
        f.write(pretty_xml)

install_dependencies()

# Configuration
LANGUAGES = [
    "English", "Czech", "French", "German", "Italian", 
    "Polish", "Portuguese", "Russian", "Spanish", 
    "Korean", "Japanese", "Chinesesimp", "Chinese"
]

# Mapping of sheet names to output paths
STRINGTABLES = {
    "ai": "addons/ai/stringtable.xml",
    "common": "addons/common/stringtable.xml",
    "game": "addons/game/stringtable.xml",
    "main": "addons/main/stringtable.xml",
    "missions": "addons/missions/stringtable.xml",
    "modules": "addons/modules/stringtable.xml",
    "sound": "addons/sound/stringtable.xml",
    "ui": "addons/ui/stringtable.xml",
}

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
ROOT_DIR = os.path.normpath(os.path.join(SCRIPT_DIR, "../"))
MASTER_ODS_PATH = os.path.join(ROOT_DIR, "stringtables/master_stringtable.ods")

# Check if master file exists
if not os.path.exists(MASTER_ODS_PATH):
    print(f"Master stringtable file not found at: {MASTER_ODS_PATH}")
    print("Creating empty XML files for all addons")
    for sheet_name, xml_rel_path in STRINGTABLES.items():
        xml_path = os.path.join(ROOT_DIR, xml_rel_path)
        create_empty_xml(xml_path)
    sys.exit(1)

try:
    # Read all sheets from master file
    xls = pd.ExcelFile(MASTER_ODS_PATH, engine="odf")
    
    # Process each sheet
    for sheet_name, xml_rel_path in STRINGTABLES.items():
        xml_path = os.path.join(ROOT_DIR, xml_rel_path)
        
        if sheet_name not in xls.sheet_names:
            print(f"Sheet '{sheet_name}' not found in master file, creating empty XML")
            create_empty_xml(xml_path)
            continue
            
        try:
            df = xls.parse(sheet_name)
            
            project = Element("Project", name="CarrierStrike")
            package = SubElement(project, "Package", name=sheet_name)
            container = SubElement(package, "Container", name=sheet_name)
            
            for _, row in df.iterrows():
                key = SubElement(container, "Key", ID=row["Key"])
                SubElement(key, "Original").text = str(row["Original"])
                
                for lang in LANGUAGES:
                    if pd.notna(row.get(lang)):
                        SubElement(key, lang).text = str(row[lang])
            
            xml_str = tostring(project, encoding="utf-8", xml_declaration=True)
            dom = parseString(xml_str)
            pretty_xml = dom.toprettyxml(indent="\t", encoding="utf-8")
            
            os.makedirs(os.path.dirname(xml_path), exist_ok=True)
            with open(xml_path, "wb") as f:
                f.write(pretty_xml)
                
            print(f"Successfully processed sheet '{sheet_name}' to {xml_rel_path}")
                
        except Exception as e:
            print(f"Error processing sheet '{sheet_name}': {e}")
            print("Creating empty XML instead")
            create_empty_xml(xml_path)

except Exception as e:
    print(f"Error reading master file: {e}")
    print("Creating empty XML files for all addons")
    for sheet_name, xml_rel_path in STRINGTABLES.items():
        xml_path = os.path.join(ROOT_DIR, xml_rel_path)
        create_empty_xml(xml_path)

print("Processing complete!")