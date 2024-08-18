{{/*
Expand the name of the chart.
*/}}
{{- define "yona.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "yona.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "yona.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "yona.labels" -}}
helm.sh/chart: {{ include "yona.chart" . }}
{{ include "yona.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "yona.selectorLabels" -}}
app.kubernetes.io/name: {{ include "yona.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
mariadb common labels
*/}}
{{- define "yona.mariadb.labels" -}}
helm.sh/chart: {{ include "yona.chart" .}}
{{ include "yona.mariadb.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
mariadb selector labels
*/}}
{{- define "yona.mariadb.selectorLabels" -}}
{{- include "yona.selectorLabels" . }}
app.kubernetes.io/component: mariadb
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "yona.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "yona.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
