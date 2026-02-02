import boto3
import os

rds = boto3.client("rds")
sns = boto3.client("sns")

RDS_IDENTIFIER = os.environ["RDS_IDENTIFIER"]
SNS_TOPIC_ARN = os.environ["SNS_TOPIC_ARN"]

def lambda_handler(event, context):
    action = event.get("ACTION")  # start or stop

    if action not in ["start", "stop"]:
        raise Exception("ACTION must be 'start' or 'stop'")

    try:
        response = rds.describe_db_instances(
            DBInstanceIdentifier=RDS_IDENTIFIER
        )
        db = response["DBInstances"][0]
        status = db["DBInstanceStatus"]

        if action == "stop" and status == "available":
            rds.stop_db_instance(DBInstanceIdentifier=RDS_IDENTIFIER)
            message = f"Stopped RDS: {RDS_IDENTIFIER}"

        elif action == "start" and status == "stopped":
            rds.start_db_instance(DBInstanceIdentifier=RDS_IDENTIFIER)
            message = f"Started RDS: {RDS_IDENTIFIER}"

        else:
            message = f"No action taken. RDS {RDS_IDENTIFIER} is in '{status}' state."

    except Exception as e:
        message = f"Error managing RDS {RDS_IDENTIFIER}: {str(e)}"

    sns.publish(
        TopicArn=SNS_TOPIC_ARN,
        Subject=f"GitLab RDS Scheduler - {action.upper()}",
        Message=message
    )

    return {
        "rds": RDS_IDENTIFIER,
        "action": action,
        "message": message
    }