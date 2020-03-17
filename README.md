# cprepo
A GitHub action that copies a file from a source path to a destination path. 
No action is taken if the same file is at both locations.

## Example usage

    - name: copy test1 from source to destination
      uses: atsu/cprepo@master
      with:
        src-path: test-src/test1.txt
        dst-path: test-dst/test1.txt
