# cprepo
A GitHub action that copies a file from a source path to a destination path. 
No action is taken if the same file is at both locations.

Why does the `atsu/cprepo` action exist? This GitHub action, in conjunction with `actions/checkout` and
`peter-evans/create-pull-request` actions, allow for reusable workflows of GitHub actions. If multiple GitHub
projects share the same build procedures, then each project may use a workflow file that is defined in single, 
separate repo, and the `actions/checkout`, `atsu/cprepo`, and `peter-evans/create-pull-request` combo ensures
that the workflow file gets copied to the downstream project via a PR. See the `Reusable workflow usage` example below.

## Inputs

### `src-path`

**Required** The path to file to be copied.

### `dst-path`

**Required** The destination path.

## Outputs

### `changed`

Set to 'yes' if the file was different and copied, otherwise set to 'no'

## Example usage

### Simple copy usage
    - name: copy test1 from source to destination
      id: cprepo-1
      uses: atsu/cprepo@master
      with:
        src-path: test-src/test1.txt
        dst-path: test-dst/test1.txt
    - name: 'show output'
      run: echo "changed =  ${{ steps.cprepo-1.outputs.changed }}"
      
### Reusable workflow usage
    on:
      push:
        branches:
        - master
      schedule:
      - cron: '0 2 * * *'
    jobs:
      sync-workflow:
        runs-on: ubuntu-latest
        steps:
        - name: 'checkout repo with the "source" workflow file'
          uses: actions/checkout@v2
          with:
            repository: your-org/workflow
            path: workflow
        - name: 'checkout "local" repo (repo that will use the shared workflow file)'
          uses: actions/checkout@master
          with:
            path: your-project
        - name: copy workflow file
          id: copy-step
          uses: atsu/cprepo@master
          with:
            src-path: workflow/shared/build.yaml
            dst-path: your-project/.github/workflows/build.yaml
        - name: Create Pull Request
          uses: peter-evans/create-pull-request@v2
          if: steps.copy-step.outputs.changed == 'yes'
          with:
            path: your-project
            commit-message: '[create-pull-request] automated change for sync-workflow'
            title: 'Changes by create-pull-request action to sync-workflow'
            labels: 'sync-workflow'
            branch: 'create-pull-request/sync-workflow'      