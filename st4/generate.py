#!/usr/bin/env python3

import json
import pathlib

SELF_DIR = pathlib.Path(__file__).parent.resolve()

BASE_PREFS = {
    # Last checked against Sublime Text 4 build 4143

    # Typing, editing, file contents
    "auto_complete_commit_on_tab": True,
    "copy_with_empty_selection": False,
    "default_line_ending": "unix",
    "ensure_newline_at_eof_on_save": True,
    "translate_tabs_to_spaces": True,
    "trim_trailing_white_space_on_save": "not_on_caret",

    # Program behavior
    "focus_on_file_drop": True,
    "preview_on_click": "only_left",
    "ignored_packages": [
        "Vintage"
    ],

    # Themes and styling
    "theme": "Alpenglow-orange.sublime-theme",
    "color_scheme": "Packages/Theme - Alpenglow/Alpenglow-monokai.tmTheme",
    "font_face": "Consolas",
    "font_size": 10,
    "caret_style": "smooth",
    "margin": 0,
    "ruler_style": "stippled",
    "bold_folder_labels": True,

    # Afterglow/Alpenglow theme-specific preferences
    # https://github.com/YabataDesign/afterglow-theme/blob/master/README.md
    # https://github.com/AlpenglowTheme/alpenglow-theme/blob/master/README.md
    "tabs_padding_small": True,
    "tabs_small": True,

    # Show/hide editor area components
    "draw_white_space": ["all"],
    "highlight_line": True,
    "indent_guide_options": ["draw_active", "draw_normal", "solid"],
    "rulers": [80, 120],

    # Show/hide interface components
    "native_tabs": "disabled",
    "always_show_minimap_viewport": True,
    "mini_diff": False,
    "show_encoding": True,
    "show_git_status": False,
    "show_line_endings": True,
    "show_rel_path": True,

    # Sidebar patterns
    "file_exclude_patterns": [
        "*.a",
        "*.class",
        "*.db",
        "*.dll",
        "*.dylib",
        "*.exe",
        "*.idb",
        "*.lib",
        "*.ncb",
        "*.o",
        "*.obj",
        "*.pdb",
        "*.psd",
        "*.pyc",
        "*.pyo",
        "*.sdf",
        "*.so",
        "*.sublime-workspace",
        "*.suo",
        ".DS_Store",
        ".coverage",
        ".directory",
        "desktop.ini"
    ],
    "folder_exclude_patterns": [
        "*.egg-info",
        ".Trash",
        ".Trash-*",
        ".git",
        ".hg",
        ".pytest*",
        ".svn",
        ".vagrant",
        "CVS",
        "__pycache__"
    ],

    # Restate default settings to normalize platform-specific behavior
    "close_windows_when_empty": False,
    "find_selected_text": True,
    "font_options": [],
    "hardware_acceleration": "none",
    "index_files": True,
    "mouse_wheel_switches_tabs": False,  # undocumented
    "move_to_limit_on_up_down": False,
    "open_files_in_new_window": "never",
    "scroll_past_end": True,
    "show_full_path": True
}

windows_prefs = {
    **BASE_PREFS,
    "font_options": ["directwrite", "dwrite_cleartype_natural"]
}

macos_prefs = {
    **BASE_PREFS,
    "font_size": int(round(BASE_PREFS["font_size"] * 1.4)),
    "hardware_acceleration": "opengl"
}

with (SELF_DIR / "Preferences.win.sublime-settings").open("w") as f:
    json.dump(windows_prefs, f, sort_keys=True, indent="\t")
    f.write('\n')

with (SELF_DIR / "Preferences.mac.sublime-settings").open("w") as f:
    json.dump(macos_prefs, f, sort_keys=True, indent="\t")
    f.write('\n')
