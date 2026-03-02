# Helm Chart Monorepo

This repository contains my Helm charts.

## Charts

- [example](./charts/example) - A Helm chart for Kubernetes.
- [go-api](./charts/go-api) - Standard Go API chart.

## How to use

Add the repository:

```bash
helm repo add my-charts https://<your-username>.github.io/<your-repo-name>
helm repo update
```

Install a chart:

```bash
helm install my-release my-charts/go-api
# or
helm install my-release my-charts/example
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
