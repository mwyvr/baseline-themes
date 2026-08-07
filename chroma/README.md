# baseline for Chroma

XML styles for code blocks in Go applications (goldmark-highlighting etc.):

```go
//go:embed baseline-dark.xml
var baselineDark string

style := chroma.MustNewXMLStyle(strings.NewReader(baselineDark))
```

The optional cyan structural layer (types, namespaces, attributes) ships
commented out, mirroring the Helix themes.
