# Go

## Modules

```sh
go mod init <module>
go mod tidy                     # add missing, remove unused deps
go get <pkg>@<version>
go get <pkg>@latest
```

## Build & run

```sh
go run .
go build -o bin/app .
go install .                    # install to $GOPATH/bin
GOOS=linux GOARCH=amd64 go build -o app .   # cross-compile
```

## Test

```sh
go test ./...
go test -run TestFoo ./...
go test -v -cover ./...
go test -bench=. ./...
go test -race ./...             # race condition detector
```

## Common patterns

```go
// error handling
if err != nil {
    return fmt.Errorf("context: %w", err)
}

// defer cleanup
defer func() { _ = f.Close() }()

// goroutine + channel
ch := make(chan int, 1)
go func() { ch <- compute() }()
result := <-ch

// context with timeout
ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
defer cancel()
```

## Tools

```sh
go vet ./...                    # static analysis
gofmt -w .                      # format code
go doc <pkg> <symbol>           # documentation
go env                          # print Go environment
dlv debug                       # delve debugger
```

## Useful env vars

```sh
GOPATH        # workspace root (~/.go by default)
GOBIN         # where go install puts binaries
GOPROXY       # module proxy (default: proxy.golang.org)
CGO_ENABLED   # 0 to disable cgo (useful for static builds)
```
