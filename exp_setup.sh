
#!/bin/bash
 
# SLURM OPTIONS
#SBATCH --job-name=MFM # Job name
#SBATCH --output=logs/${JOB_NAME}.out # Standard output file
#SBATCH --error=logs/${JOB_NAME}.err # Standard error file
#SBATCH --open-mode=truncate # Open mode
#SBATCH --time=0-23:58:00 # Maximum run time (adjust as needed, maximum 7 days 7-00:00:00)
#SBATCH --partition=gpu # Partition name
#SBATCH --nodes=1 # Number of nodes (adjust as needed)
#SBATCH --ntasks=2 # Total number of tasks
#SBATCH --ntasks-per-node=2 # Number of tasks per node
#SBATCH --cpus-per-task=12 # Number of CPUs per task
#SBATCH --gres=gpu:2 # GPUs per node
#SBATCH --mem=32GB # Total memory
 
# Load Anaconda
module load Anaconda3
# You need this to be able to use the 'conda' command. I am not satisfied with this solution, I'll try to find a way so that you won't have to set it in the future.
source /opt/easybuild/software/Anaconda3/2024.02-1/etc/profile.d/conda.sh
 
# Set up Conda environment
environment_name="MFM"
 
# Create and activate Conda environment if it doesn't exist
if ! conda info --envs | grep -q "^${environment_name}"; then
  conda create -n ${environment_name} python=3.11 -y
  conda activate ${environment_name}
  pip install --no-cache-dir -r requirements.txt
  python -m pip check
else
  conda activate ${environment_name}
  python -m pip check
fi
 
# Print confirmation if environment is activated
if [[ $? -eq 0 ]]; then
    echo "Conda environment '${environment_name}' activated successfully."
else
    echo "Failed to activate Conda environment '${environment_name}'. Exiting."
    exit 1
fi
 
## deactivate http proxy variable so TensorFlow doesn't try to connect
set -x
unset http_proxy HTTP_PROXY https_proxy HTTPS_PROXY
 
## run script in parallel
srun python3 main_mfm.py 