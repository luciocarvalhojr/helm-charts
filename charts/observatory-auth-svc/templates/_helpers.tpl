{{/*
Expand the name of the chart.
*/}}
{{- define "observatory-auth-svc.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "observatory-auth-svc.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "observatory-auth-svc.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/name: {{ include "observatory-auth-svc.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "observatory-auth-svc.selectorLabels" -}}
app.kubernetes.io/name: {{ include "observatory-auth-svc.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
