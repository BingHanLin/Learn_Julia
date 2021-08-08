http://pkgdocs.julialang.org/v1/creating-packages/

1. Generate files for a new package

    ```
    generate helloWorld
    ```

2. Go to package folder

    ```
    cd("helloWorld")
    ```

3. Test **helloWorld** package

    ```
    pkg> activate .

    julia> import helloWorld

    julia> helloWorld.greet()
    Hello World!
    ```

4. Adding dependencies to the projects
    ```
    pkg> add Random
    ```

5. Adding a build step to the package(deps/build.jl)   
    ```
    (helloWorld) pkg> build
    ```

6. Adding tests to the package(test/runtests.jl)
    ```
    (helloWorld) pkg> test
    ```
