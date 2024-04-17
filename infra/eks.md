# Accessing EKS
## setup
### Get the kubeconfig file from `AWSCLI`
To get the `kubeconfig` file for your Amazon EKS cluster, you can use the AWS CLI or AWS Management Console. Here's how you can do it using the AWS CLI:

1. Install and configure the AWS CLI if you haven't done so already.

2. Install the `aws-iam-authenticator` tool. This tool is used to authenticate to your EKS cluster.

3. Run the following command to update your `kubeconfig` file with the information for your EKS cluster:

```bash
aws eks --region region update-kubeconfig --name cluster_name
```

   Replace `region` with the AWS region your EKS cluster is in, and replace `cluster_name` with the name of your EKS cluster.

If you don't have credentials configured for aws via `aws config` be sure to add a flag for profile reference e.g. `--profile production` (if that's what you're using to authenticate).

This command updates the `kubeconfig` file in the default location (usually `~/.kube/config`). If you want to use a different file, you can set the `KUBECONFIG` environment variable to the path of the file.

After running this command, you should be able to use `kubectl` to interact with your EKS cluster. For example, `kubectl get svc` should return a list of the services in your cluster.

### Manually set the kubeconfig file

The `kubeconfig` file is typically located in the home directory of the user under `.kube/config`. If you want to use a different location, you can set the `KUBECONFIG` environment variable to point to the file.

Here's how you can set the `KUBECONFIG` environment variable:

- On Linux or macOS:

```bash
export KUBECONFIG=/path/to/your/kubeconfig
```

Replace `/path/to/your/kubeconfig` or `C:\path\to\your\kubeconfig` with the actual path to your `kubeconfig` file.

After setting the `KUBECONFIG` environment variable, you can use `kubectl` commands without the `--kubeconfig` option. For example, `kubectl get nodes` will use the `kubeconfig` file specified by the `KUBECONFIG` environment variable.
## accessing pods 
To access Amazon EKS (Elastic Kubernetes Service) from the shell, you first need to install and configure `kubectl`, the Kubernetes command-line tool. Once `kubectl` is set up, you can use it to interact with your EKS cluster. *this package can be installed via `brew`*

Here's an example command to get the nodes in your EKS cluster:

```bash
kubectl get nodes --kubeconfig /path/to/your/kubeconfig
```

In this command, replace `/path/to/your/kubeconfig` with the path to your kubeconfig file. This file contains the information needed to connect to your EKS cluster.

If you've set the `KUBECONFIG` environment variable to point to your kubeconfig file, you can omit the `--kubeconfig` option:

```bash
export KUBECONFIG='/path/to/your/kubeconfig'
kubectl get nodes
```

These commands will return a list of the nodes in your EKS cluster.