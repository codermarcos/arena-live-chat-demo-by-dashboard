# 💡 Arena Live Chat Demo *(by codermarcos)*

This is simple example using [Arena Live Chat](https://arena.im/products/live-chat/all-features).

**This project** uses typescript, ejs and webpack to bundle a static page and deploying to AWS S3.

> **Table of contents**
> - [🔍 Requirements](#requirements)
> - [🔨 Project setup](#project-setup)
> - [📑 Available Scripts](#️available-scripts)
>   - [Server for development](#️server-for-development)
>   - [Build](#️build)
>   - [Check linter](#check-linter)
> - [⬆️ Deploy environment locally](#deploy-locally)
> - [🔥 Destroy environment locally](#destroy-locally)
> - [📚 Learn more](#learn-more)
> - [💪 Dev Team](#dev-team)

## <a name="requirements"></a> 🔍 Requirements

| Dependencies                                 | Description               |
| -------------------------------------------- | ------------------------- |
| [![node-version]][node-download]             | Javascript Runtime        |
| [![terraform-version]][terraform-download]   | Terraform                 |
| [![terragrunt-version]][terragrunt-download] | Wrapper for Terraform     |

## <a name="project-setup"></a> 🔨 Project setup

1. To **clone repository** you need to have [git](https://git-scm.com/downloads) installed:

```bash
git clone
```

2. Enter repository

```bash
cd personal
```

3. To **install dependencies** you need to have [NodeJS](https://nodejs.org/en/) installed:

```bash
npm install
```

### <a name="build"></a> Build

Builds the app for production to the `dist` folder.

```bash
npm run build
```

## <a name="deploy-locally"></a> ⬆️ Deploy environment locally

To deploy locally you need run [build](#️build) before proceed.

1. To create the s3 bucket use this, you need terragrunt [terragrunt][terragrunt-download] installed:

```bash
terragrunt apply --terragrunt-working-dir iac --terragrunt-source .
```

> To learn more [Terragrunt](https://terragrunt.gruntwork.io/docs/).

## <a name="destroy-locally"></a> 🔥 Destroy environment locally

1. Now destroy s3 bucket with terraform

```bash
terragrunt destroy --terragrunt-working-dir iac --terragrunt-source .
```

## <a name="learn-more"></a> Learn More

* [Terraform](https://learn.hashicorp.com/terraform?utm_source=terraform_io&utm_content=terraform_io_hero)
* [AWS](https://docs.aws.amazon.com/s3/?id=docs_gateway)

## <a name="dev-team"></a> 💪 Dev Team

This project exists thanks to all these people.

[![Marcos](https://avatars3.githubusercontent.com/u/12430365?s=100)](https://github.com/codermarcos)

[terraform-download]: https://learn.hashicorp.com/tutorials/terraform/install-cli
[terragrunt-download]: https://terragrunt.gruntwork.io/docs/getting-started/install/
[node-download]: https://nodejs.org/download/release/v14.14.0/
[terraform-version]: https://img.shields.io/badge/terraform-latest-blue
[terragrunt-version]: https://img.shields.io/badge/terragrunt-latest-blue
[node-version]: https://img.shields.io/badge/node-latest-blue
