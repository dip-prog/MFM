
SBATCH --partition=gpu-2080ti  # Partition is a queue for jobs
SBATCH --time=02:00:00         # Time limit for the job
SBATCH --job-name=python_app   # Name of your job
SBATCH --error=job-%j.err
SBATCH --output=job-%j.out
SBATCH --nodes=1               # Number of nodes you want to run your process on
SBATCH --ntasks-per-node=1     # Number of CPU cores
SBATCH --mem=10GB
SBATCH --gres=gpu:2            # Number of GPUs
  