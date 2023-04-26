#!/bin/bash

{{/*
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/}}

set -e

/tmp/neutron-openvswitch-agent-readiness.sh

python \
    /tmp/health-probe.py \
    --config-file \
    /etc/neutron/neutron.conf \
    --config-file \
    /etc/neutron/plugins/ml2/openvswitch_agent.ini \
    --agent-queue-name \
    q-agent-notifier-tunnel-update \
    --liveness-probe
{{- if .Values.pod.use_fqdn.neutron_agent }}
    --use-fqdn \
{{- end }}
    --liveness-probe
