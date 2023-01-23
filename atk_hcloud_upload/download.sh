sync_folder_host_local() {

    local_path=$1
    remote_path=/home/$2/ # project_name
    project=$2
    
    # path where exp_ineriments exists (input_folder,metadata_folder,output_folder)
    exp_in=$3 # input_folder name
    host=$4

    if rclone --config ~/.ssh/rclone.conf ls hcloud:/home | grep -q "$project" ; then
      echo "############# PROJECT EXISTS  ################"
      echo "############# LOOKING FOR FOLDER  #############"
      #rsync -avz --ignore-existing -e 'ssh -p 23 -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no' /dev/null $host:$remote_path &>/dev/null
      if ! rclone --config ~/.ssh/rclone.conf ls hcloud:$remote_path | grep -q "$exp_in"; then
        echo "######### THE FOLDER YOU ARE LOOKING FOR DOES NOT EXIST IN GIVEN PROJECT"
      else
        rsync -avzP -e 'ssh -p 23 -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no' $host:$remote_path/$exp_in/ $local_path
        echo "########## FOLDER HAS BEEN SYNCED TO LOCAL ############"
      fi
        
    else
      echo "############# PROJECT DOES NOT EXIST ################"
      
    fi

}


    # check if remote folder already exists
    
# USAGE
#sync_folder_host_local "/Users/nitesh/Desktop/work/atk-packages/atk-hcloud-upload/out/" "test1" "input_folder" "u332964-sub1@95.217.92.102"
sync_folder_host_local $1 $2 $3 $4