import os
import json
import argparse

def generate_colorset(color_name, hex_value):
    colorset_dir = f"{color_name}.colorset"
    contents = {
        "colors": [
            {
                "color": {
                    "color-space": "srgb",
                    "components": {
                        "alpha": "1.000",
                        "blue": "",
                        "green": "",
                        "red": ""
                    }
                },
                "idiom": "universal"
            }
        ],
        "info": {
            "author": "xcode",
            "version": 1
        }
    }

    r, g, b, a = tuple(int(hex_value[i:i+2], 16) for i in (1, 3, 5, 7))
    contents["colors"][0]["color"]["components"]["red"] = f"0x{r:02X}"
    contents["colors"][0]["color"]["components"]["green"] = f"0x{g:02X}"
    contents["colors"][0]["color"]["components"]["blue"] = f"0x{b:02X}"
    contents["colors"][0]["color"]["components"]["alpha"] = f"{a/255:.3f}"

    os.makedirs(colorset_dir, exist_ok=True)
    with open(os.path.join(colorset_dir, "Contents.json"), "w") as f:
        json.dump(contents, f, indent=2)

def main():
    parser = argparse.ArgumentParser(description="Generate Xcode colorset directories and files.")
    parser.add_argument("colors", nargs="+", help="List of color names and hex values in the format name:hex")
    args = parser.parse_args()

    for color_arg in args.colors:
        color_name, hex_value = color_arg.split(":")
        generate_colorset(color_name, hex_value)

if __name__ == "__main__":
    main()
