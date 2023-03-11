# tf-gcp-organization
Arrow Terraform - GCP Organization management

## Running local plan

Before pushing your code to GitHub, you might want to double check if the Terraform plan output shows what you're expecting.
If you're owning an Arrow provided email address, you can run a local plan using the provided Makefile.

### Install gcloud

Make sure you have the gcloud cli installed on your machine. This is required to get an auth token using your Arrow account.
Instructions can be found here: https://cloud.google.com/sdk/docs/install

### Get an application login token

```
gcloud auth application-default login
```

This command will open up a browser tab and asks you to select the google account you want to log in with. Select your Arrow account here.
A temporary key will be saved on your PC. This is usually stored in the `~/.config/gcloud/` directory.
If the `application_default_credentials.json` file exists, and if you have the right permissions in GCP, you should be able to run the Terraform make targets.

### Create local vars file
This project requires two variables to run. These variables are provided as a secret for GitHub actions, but you will need to create a `local.auto.tfvars` file manually if you want to run terraform locally.

```
cat << EOF > src/local.auto.tfvars
gcp_org_id          = <arrow gcp org id>
gcp_billing_account = "<arrow billing account id>"
EOF
```

If you don't have permission to look up the values for these variables, you will not have permissions to run local plans either.

### Run Terraform plan
```
make tf-plan-services-global-all
```

## Initial setup

In the beginning, there was no GCP infra...

That's why we had to manually run a plan and apply action using a privileged user account.
The following steps describe how the set up was done.

### Assign required roles
Assign the following roles in your GCP organization to a trusted user account:
- Folder Admin
- Security Admin
- Organization Administrator
- Organization Role Administrator
- Project Lien Modifier

### Run Terraform
Make sure you have retrieved an application login token as described above.

```
cd src/
mv backend.tf backend.tf.bak
Terraform init -reconfigure
Terraform workspace new services-global-all
TF_VAR_tf_project=org Terraform plan
TF_VAR_tf_project=org Terraform apply
mv backend.tf.bak backend.tf
rm -rf .Terraform
```

### Move local state to new tfstate bucket
```
gsutil cp -r terraform.tfstate.d/services-global-all gs://arw-services-global-all-org-tfstate/organization/
```

### Test make targets
You should now be able to run Terraform using the provided make targets. Make sure everything is working and adjust group permissions if needed.
