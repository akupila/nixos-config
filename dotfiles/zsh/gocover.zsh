function gocover () {
  FILE=$(mktemp)
  go test -coverprofile=$FILE $@
  go tool cover -html=$FILE
  rm $FILE
}
