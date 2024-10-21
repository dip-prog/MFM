
#!/bin/bash

# Check if ROS is sourced
if [ -z "$ROS_PACKAGE_PATH" ]; then
  echo "Please source your ROS workspace first."
  exit 1
fi

# Topic where the pose graph is published (e.g., for rtabmap)
POSE_GRAPH_TOPIC="/rtabmap/graph"

# Function to extract the number of nodes and clusters from the pose graph
function get_slam_clusters_and_nodes() {
    echo "Subscribing to $POSE_GRAPH_TOPIC to extract SLAM information..."

    # Use rostopic to check the current state of the pose graph
    # You can use `rostopic echo` to view the structure, then filter for node count
    # Here we're using rostopic echo to get the number of nodes in the graph
    node_count=$(rostopic echo -n 1 "$POSE_GRAPH_TOPIC" | grep "nodes" | wc -l)

    echo "Number of nodes in the SLAM graph: $node_count"

    # For clustering, we assume the clusters may be stored as an adjacency list
    # or some kind of group structure. For demonstration, you would parse the 
    # relevant part of the pose graph message here.

    # Example (adjust depending on the actual message type):
    cluster_count=$(rostopic echo -n 1 "$POSE_GRAPH_TOPIC" | grep "clusters" | wc -l)

    echo "Number of clusters detected: $cluster_count"
}

# Call the function to get cluster and node info
get_slam_clusters_and_nodes