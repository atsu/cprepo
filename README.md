# cprepo
A GitHub action that copies a file from a source path to a destination path. 
No action is taken if the same file is at both locations.

## Inputs

### `src-path`

**Required** The path to file to be copied.

### `dst-path`

**Required** The destination path.

## Outputs

### `changed`

Set to 'yes' if the file was different and copied, otherwise set to 'no'

## Example usage

    - name: copy test1 from source to destination
      id: cprepo-1
      uses: atsu/cprepo@master
      with:
        src-path: test-src/test1.txt
        dst-path: test-dst/test1.txt
    - name: 'show output'
      run: echo "changed =  ${{ steps.cprepo-1.outputs.changed }}"