# Django Test CI Action

A Django CI Github Action which runs your tests with a postgres database.

**NOTE: You can use the DB service of your choice for your django app, using this action won't restrict you to postgres**

## Arguments

#### `settings-dir-path`
The relative path of the directory containing your settings file. This is used to integrate the DB with your app. 

**This value is required**

#### `parallel-tests`
Enable/Disable Parallel Tests. Default is false.

## Workflow Example

```
uses: actions/checkout@v2
name: Django CI
uses: UKnowWhoIm/django-test-action@main
with:
  settings-dir-path: "testproject"
```
