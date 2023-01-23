import typer,os
shell_s=os.path.dirname(os.path.abspath(__file__))

app=typer.Typer()

@app.command()
def sync(project:str,local_path:str,inp_dir_name:str,host:str):
    """
    args: project here is name of the project that will be created in /home folder of storage
    project="minimisation"
    loca_path here is the path where the input folder lies its an absolute path,
    input_dir_name here is name of input folder you are pushing
    host here is admin provided name 
    """
    try:

      os.system(f"/bin/bash {shell_s}/download.sh {local_path} {project} {inp_dir_name} {host}")
    except Exception as e:
        print("Please provide correct host name, and check your ~/.ssh/rclone.conf file , or get a correct authentication from admin")

def main():
    app()

# if __name__=='__main__':
#     sync('tests','/Users/nitesh/Desktop/work/atk-packages/atk-hcloud-upload/out/','docker-compose.yaml_2',"u332964-sub1@95.217.92.102")


