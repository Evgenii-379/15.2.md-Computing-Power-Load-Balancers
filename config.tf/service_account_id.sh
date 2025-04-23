SERVICE_ACCOUNT_ID="ajejhtfl4ll3t1kmqgtj"
FOLDER_ID="b1gt6sro0sp7kjv4dnh1"

# Разрешения для Object Storage
yc resource-manager folder add-access-binding $FOLDER_ID \
  --role storage.admin \
  --service-account-id $SERVICE_ACCOUNT_ID

# Разрешения для работы с сетью
yc resource-manager folder add-access-binding $FOLDER_ID \
  --role vpc.publicAdmin \
  --service-account-id $SERVICE_ACCOUNT_ID

# Разрешения на запуск ВМ
yc resource-manager folder add-access-binding $FOLDER_ID \
  --role compute.editor \
  --service-account-id $SERVICE_ACCOUNT_ID
