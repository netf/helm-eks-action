# helm-eks-action
Github Action for  executing Helm commands on EKS (using aws-iam-authenticator).

The Helm version installed is Helm3.

This action was inspired by [kubernetes-action](https://github.com/Jberlinsky/kubernetes-action).

# Instructions

This Github Action was created with EKS in mind, therefore the following example refers to it.

## Example

```yaml
name: deploy

on:
    push:
        branches:
            - master
            - develop

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - name: AWS Credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: eu-west-2

      - name: helm deploy
        uses: netf/helm-eks-action@v1
        with:
          cluster-name: test-cluster
          command: helm upgrade <release name> --install --wait <chart> -f <path to values.yaml>
```

# Response

Use the output of your command in later steps

```yaml
    steps:
      - name: Get URL
        id: url
        uses: netf/helm-eks-action@v1
        with:
          cluster-name: test-cluster
          command: kubectl get svc my_svc -o json | jq -r '.status.loadBalancer.ingress[0].hostname'

      - name: Print Response
        run: echo "Response was ${{ steps.url.outputs.response }}"

```

# Secrets

Create a GitHub Secret for each of the following values:

* `AWS_ACCESS_KEY_ID`

* `AWS_SECRET_ACCESS_KEY`

# Contributions

Pull requests, issues or feedback of any kind are more than welcome by anyone!
