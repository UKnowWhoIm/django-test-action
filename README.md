# Django Test CI Action

A Django CI Github Action which runs your tests with a postgres database.

**NOTE: You can use the DB service of your choice for your django app, using this action won't restrict you to postgres**

## Arguments

#### `settings-dir-path`
The relative path of the directory containing your settings file. This is used to integrate the DB with your app. 

**This value is required**

#### `parallel-tests`
Enable/Disable Parallel Tests. Default is false.

#### `requirements-file`
Path of the file containing the dependancies, default is requirements.txt

#### `env-file`
Path of the the file containoing additional environment variables.

`SECRET_KEY`, `DEBUG` and `DATABASES` are manually set, if your django app depends on any other environment variable, set them in this file or set them like this
```
name: Django CI
env: 
  - API_KEY: "dummy_api_key"
```

**WARNING: Don't store sensitive data, use random dummy data only**

If you have to use sensitive data(highly not recommended in a test environment), store them as a [repository secret](https://docs.github.com/en/actions/reference/encrypted-secrets) and include them in the workflow file.
```
steps:
  - name: Django CI
    env: 
      super_secret: ${{ secrets.SuperSecret }}
```


## Workflow Example

```
uses: actions/checkout@v2
name: Django CI
uses: UKnowWhoIm/django-test-action@v0.5.1
with:
  settings-dir-path: "testproject"
```
