#!/usr/bin/env bash
# One-shot setup: creates the 'Hedging job details' property group + 7 custom
# contact properties for Hertfordshire Hedging. Safe to re-run (409 = exists).
set -euo pipefail

cd "$(dirname "$0")/.."
set -a; . ./.env; set +a

API="https://api.hubapi.com"
AUTH="Authorization: Bearer ${HUBSPOT_TOKEN}"
CT="Content-Type: application/json"

post() {
  local path="$1" body="$2"
  local code
  code=$(curl -sS -o /tmp/hs_resp.json -w "%{http_code}" \
    -X POST "${API}${path}" -H "$AUTH" -H "$CT" -d "$body")
  case "$code" in
    201) echo "  -> created";;
    409) echo "  -> already exists, skipping";;
    *)   echo "  -> ERROR $code:"; cat /tmp/hs_resp.json; echo; exit 1;;
  esac
}

echo "Creating property group: hedging_job_details"
post "/crm/v3/properties/contacts/groups" '{
  "name":"hedging_job_details","label":"Hedging job details","displayOrder":-1
}'

echo "Creating property: service_interest"
post "/crm/v3/properties/contacts" '{
  "name":"service_interest","label":"Service interest","groupName":"hedging_job_details",
  "type":"enumeration","fieldType":"checkbox",
  "description":"Which services the contact has enquired about or had done.",
  "options":[
    {"label":"Supply only","value":"supply_only","displayOrder":0},
    {"label":"Planting","value":"planting","displayOrder":1},
    {"label":"Maintenance","value":"maintenance","displayOrder":2},
    {"label":"Removal","value":"removal","displayOrder":3},
    {"label":"Consultation","value":"consultation","displayOrder":4}
  ]
}'

echo "Creating property: hedge_species"
post "/crm/v3/properties/contacts" '{
  "name":"hedge_species","label":"Hedge species","groupName":"hedging_job_details",
  "type":"enumeration","fieldType":"checkbox",
  "description":"Species the contact has, wants, or has had planted.",
  "options":[
    {"label":"Beech","value":"beech","displayOrder":0},
    {"label":"Hornbeam","value":"hornbeam","displayOrder":1},
    {"label":"Yew","value":"yew","displayOrder":2},
    {"label":"Laurel","value":"laurel","displayOrder":3},
    {"label":"Mixed native","value":"mixed_native","displayOrder":4},
    {"label":"Other","value":"other","displayOrder":5}
  ]
}'

echo "Creating property: property_type"
post "/crm/v3/properties/contacts" '{
  "name":"property_type","label":"Property type","groupName":"hedging_job_details",
  "type":"enumeration","fieldType":"select",
  "description":"Type of property the work is for.",
  "options":[
    {"label":"Private residence","value":"private_residence","displayOrder":0},
    {"label":"Estate","value":"estate","displayOrder":1},
    {"label":"Commercial","value":"commercial","displayOrder":2},
    {"label":"School / Public","value":"school_public","displayOrder":3},
    {"label":"Other","value":"other","displayOrder":4}
  ]
}'

echo "Creating property: job_status"
post "/crm/v3/properties/contacts" '{
  "name":"job_status","label":"Job status","groupName":"hedging_job_details",
  "type":"enumeration","fieldType":"select",
  "description":"Where this contact / job sits in the pipeline.",
  "options":[
    {"label":"Enquiry","value":"enquiry","displayOrder":0},
    {"label":"Quoted","value":"quoted","displayOrder":1},
    {"label":"Booked","value":"booked","displayOrder":2},
    {"label":"In progress","value":"in_progress","displayOrder":3},
    {"label":"Completed","value":"completed","displayOrder":4},
    {"label":"Lost","value":"lost","displayOrder":5}
  ]
}'

echo "Creating property: quote_value_gbp"
post "/crm/v3/properties/contacts" '{
  "name":"quote_value_gbp","label":"Quote value (GBP)","groupName":"hedging_job_details",
  "type":"number","fieldType":"number",
  "description":"Value of the most recent quote in GBP."
}'

echo "Creating property: lead_source"
post "/crm/v3/properties/contacts" '{
  "name":"lead_source","label":"Lead source","groupName":"hedging_job_details",
  "type":"enumeration","fieldType":"select",
  "description":"How the contact first found Hertfordshire Hedging.",
  "options":[
    {"label":"Website form","value":"website_form","displayOrder":0},
    {"label":"Referral","value":"referral","displayOrder":1},
    {"label":"Google","value":"google","displayOrder":2},
    {"label":"Repeat customer","value":"repeat_customer","displayOrder":3},
    {"label":"Other","value":"other","displayOrder":4}
  ]
}'

echo "Creating property: last_job_date"
post "/crm/v3/properties/contacts" '{
  "name":"last_job_date","label":"Last job date","groupName":"hedging_job_details",
  "type":"date","fieldType":"date",
  "description":"Date of the most recent completed job."
}'

echo
echo "All done."
