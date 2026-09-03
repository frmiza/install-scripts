#!/bin/bash

function install-packages() {
    local -n list_packages="$1"
    local log_file="$2"
    local package_type="$3"

    if [[ -n "$log_file" ]]; then
        touch "$log_file"
    fi

    echo "=== Starting installation for: $package_type ===" | tee -a "$log_file"

    for package in "${list_packages[@]}"; do
        [[ -z "$package" ]] && continue

        echo "Installing: $package" | tee -a "$log_file"

        if sudo pacman -S --needed --noconfirm "$package" >> "$log_file" 2>&1; then
            echo "✓ $package installed successfully" | tee -a "$log_file"
        else
            echo "✗ Failed while installing $package" | tee -a "$log_file"
        fi
        echo "----------------------------------------" >> "$log_file"
    done
}

function installer() {
    local json_file="$1"
    local log_directory="$2"
    local graphic_type="$3"
    
    if [[ ! -f "$json_file" ]]; then
        echo "Error: JSON file '$json_file' not found!"
        return 1
    fi

    mkdir -p "$log_directory"
    
    local modules
    mapfile -t modules < <(jq -r '.Packages | keys_unsorted[]' "$json_file" 2>/dev/null)


    for module in "${modules[@]}"; do
      
      if [[ "$module" == "Window-Manager" ]]; then
        local wm_modules
        mapfile -t wm_modules < <(jq -r ".Packages.\"Window-Manager\".\"$graphic_type\" | keys_unsorted[]" "$json_file" 2>/dev/null)
        
        for wm_module in "${wm_modules[@]}"; do
          local packages=()
          mapfile -t packages < <(jq -r ".Packages.\"Window-Manager\".\"$graphic_type\".\"$wm_module\"[]" "$json_file" 2>/dev/null)
          install-packages "packages" "$log_directory/$graphic_type-$wm_module" "$graphic_type: $wm_module"
        done
        
        continue 
      fi

      local data_type
      data_type=$(jq -r ".Packages.\"$module\" | type" "$json_file")

      if [[ "$data_type" == "array" ]]; then
        local packages=()
        mapfile -t packages < <(jq -r ".Packages.\"$module\"[]" "$json_file" 2>/dev/null)
        install-packages "packages" "$log_directory/$module" "$module"
          
      elif [[ "$data_type" == "object" ]]; then
        local submodules
        mapfile -t submodules < <(jq -r ".Packages.\"$module\" | keys_unsorted[]" "$json_file" 2>/dev/null)
          
        for submodule in "${submodules[@]}"; do
          local packages=()
          mapfile -t packages < <(jq -r ".Packages.\"$module\".\"$submodule\"[]" "$json_file" 2>/dev/null)
          install-packages "packages" "$log_directory/$module-$submodule" "$module ($submodule)"
        done
      fi

    done
}
