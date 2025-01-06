# tempdir.plugin.zsh

tempdir_file="/tmp/tempdir_list.txt"

# Create a temporary directory and enter it
temp_create() {
    local dir_name=$(mktemp -d)
    echo ${dir_name} >> ${tempdir_file}
    cd ${dir_name}
}

# List all temporary directories
temp_list() {
    echo -e "\033[1;34mTemporary directories:\033[0m"
    nl ${tempdir_file} || echo -e "\033[1;33mNo temporary directories.\033[0m"
}

get_temp_path() {
    sed -n ${1}p ${tempdir_file}
}

number_check() {
    if [ -z $1 ]; then
        echo -e "\033[1;31mPlease specify the number of the temporary directory.\033[0m"
        return 1
    fi
    local line=$(get_temp_path $1)
    if [ -z ${line} ]; then
        echo -e "\033[1;31mNo such temporary directory.\033[0m"
        return 1
    fi
}

# Delete a temporary directory
temp_delete() {
    number_check $1 || return 1
    rm -rf $(get_temp_path $1)
    sed -i ${1}d ${tempdir_file}
}

# Go to a temporary directory
temp_go() {
    number_check $1 || return 1
    cd $(get_temp_path $1)
}

# Aliases
alias tempc="temp_create"
alias templ="temp_list"
alias tempd="temp_delete"
alias tempg="temp_go"
