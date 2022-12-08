#!/usr/bin/env python3

import yaml
import sys
import boto3


file_name = sys.argv[1]

with open(file_name, "r") as stream:
    try:
        data = yaml.safe_load(stream)
    except yaml.YAMLError as exc:
        print(exc)

if __name__ == "__main__":

    client = boto3.client('service-quotas')

    for item in data:
        ##  get request history
        history = client.list_requested_service_quota_change_history_by_quota(
            ServiceCode=item["service_code"],
            QuotaCode=item["quota_code"]
        )
        ## get current quota
        current_quota_response = client.get_service_quota(
            ServiceCode=item["service_code"],
            QuotaCode=item["quota_code"]
        )

        ## check if there is a open case, history["RequestedQuotas"][0] is the latest request in hisotry.
        if len(history["RequestedQuotas"]) > 0 and history["RequestedQuotas"][0]["Status"] != "CASE_CLOSED":
            print("Skipping .... Only one open service quota increase request is allowed per quota. %s - %s - %s" % (item["service_code"], item["name"],item["quota_code"] ) )
            continue

        ## check if the desired quota > current quota
        elif item["desired_value"] > current_quota_response["Quota"]["Value"]:
            response = client.request_service_quota_increase(
                ServiceCode=item["service_code"],
                QuotaCode=item["quota_code"],
                DesiredValue=item["desired_value"]
            )
            print("Service Requested Quota is : %s-%s-%s value=%d " % (item["service_code"], item["name"], item["quota_code"],item["desired_value"]))
            continue
        
        print("Desired Value %s must be greater than current quota %s." % (item["quota_code"], current_quota_response["Quota"]["Value"]))