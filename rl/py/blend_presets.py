import json, os

dest  = os.path.expandvars(r"%APPDATA%\bakkesmod\bakkesmod\data\acplugin\Presets\_Presets.json")
source = os.path.join(os.path.join(os.path.dirname(os.path.abspath(__file__)),"..","configs", "bakkesmod", "cfg", "_Presets.json"))

with open(dest, "r") as f:
    DEST_DATA = json.load(f)

with open(source, "r") as f:
    SOURCE_DATA = json.load(f)

for key, value in SOURCE_DATA.items():
    if key not in DEST_DATA:
        DEST_DATA[key] = value
    elif DEST_DATA[key] != value:
        new_key = key
        counter = 2
        while new_key in DEST_DATA:
            new_key = f"{key}({counter})"
            counter += 1
        DEST_DATA[new_key] = value

with open(dest, "w") as f:
    json.dump(DEST_DATA, f, indent=4)

