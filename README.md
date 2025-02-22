# magnet-tester-openscad

OpenSCAD script to generate magnet-strength-tester

## Usage

If you would only generate a small number of tester choose `magnet-tester.scad`, edit the values directly in OpenSCAD and export your models.

```scad
generate = ["all"|"base"|"text"]
diameter = [number]
height = [number]
cover = [number]
```
__generate__
- "all": generate the hole model, useful for first impression
- "base": generate base with text on top of cover layer
- "text": generate text for base, cover layers and help text on print bed

__diameter__ -- diameter of your magnet in mm

__height__ -- height of your magnet in mm

__cover__ -- number of layers to cover the magnet

If you need to generate multiple tester in different dimensions, chose `./make` bash-script to generate them.

```bash
## diameter of magnet
DIAMETER=(4 5 6 8 10 12 15 20)
## height of magnet
HEIGHT=(2 3)
## number of layers above magnet
COVER=(3 5)
```

Variables are the same as above in `magnet-tester.scad` but they are lists that are processed in every combination. All files are saved to the `export/` folder.

For each tester, two files are generated:
- `4x2-5_base.stl`
- `4x2-5_text.stl`

The file name contains the following information: `(diameter)x(height)-(cover)_(base|text).stl`

## Printing

For printing a multicolor printer is recommended. If you use Bambustudio, import both files for the same magnet at once and choose "load as one object with multiple items" if asked. Then change the color for the text layer.
