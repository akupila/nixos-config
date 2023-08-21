function gocover() {
  PKG="${1:-./...}"
  FILE=$(mktemp)
  go test -coverprofile=$FILE $PKG
  go tool cover -html=$FILE
  rm $FILE
}
