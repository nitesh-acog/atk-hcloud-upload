sync_folder_local_host() {

    local_path=$1
    remote_path=/home/$2 # project_name
    project=$2
    
    # path where exp_ineriments exists (input_folder,metadata_folder,output_folder)
    exp_in=$3 # input_folder name
    host=$4

    if ! rclone --config ~/.ssh/rclone.conf ls hcloud:/home | grep -q "$project" ; then
      echo "############# CREATING THE PROJECT  ################"
      rsync -avz --ignore-existing -e 'ssh -p 23 -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no' /dev/null $host:$remote_path &>/dev/null
    else
      echo "############# PROJECT ALREADY EXISTS ################"
      
    fi


    # check if remote folder already exists
    if rclone --config ~/.ssh/rclone.conf ls hcloud:$remote_path | grep -q "$exp_in"; then
        echo "################  SYNCING THE FOLDER  ##################"
        suffix=0
        new_folder_name="$exp_in"
        while rclone --config ~/.ssh/rclone.conf ls hcloud:$remote_path | grep -q "${new_folder_name}"; do
            suffix=$((suffix + 1))
            new_folder_name="${exp_in}_$suffix"
        done
        echo "####### FOLDER WILL BE PUSHED INTO CLOUD WITH NAME --->  ${new_folder_name}"
        #rclone --config /root/.ssh/rclone.conf move hcloud:$remote_path hcloud:${remote_path}/${new_folder_name}
        remote_path="${remote_path}/${new_folder_name}"
    
      
    fi
    # Use the --ignore-existing option to skip files that already exist in the remote folder
    
    rsync -avzP -e 'ssh -p 23 -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no' $local_path/$exp_in/ $host:$remote_path
    echo "##################  SUCCESSFULLY SYNCED THE FOLDER WITH CLOUD  ########################"
}

# USAGE
#sync_folder_local_host "/Users/nitesh/Desktop/work/atk-packages/atk-hcloud-upload/out/" "traefik" "input_folder" "u332964-sub1@95.217.92.102"
sync_folder_local_host $1 $2 $3 $4