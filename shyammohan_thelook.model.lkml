connection: "thelook"

# include all the views
include: "*.view"

datagroup: shyammohan_thelook_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

#-------->>>  DATAGROUP - CACHE FOR 4 HRS <<<-----------------------
datagroup: orders_datagroup {
  max_cache_age: "4 hours"
}

persist_with: shyammohan_thelook_default_datagroup

#-------->>>  JOIN WITH 'FIELDS' PARAMETER <<<-----------------------
#-------->>>  'VIEW LABEL' USED <<<------------------------------
#-------->>>  'INNER JOIN' USED <<<-----------------------
explore: distribution_centers {
  join: products{
    view_label: "Product (Limited Fields)"
    type: inner
    sql_on: ${distribution_centers.id}=${products.distribution_center_id} ;;
    relationship: many_to_one
    fields: [products.sku,products.name,products.retail_price,products.count]
  }
}

explore: etl_jobs {}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
#-------->>>  'SQL ALWAYS WHERE' FILTER APPLIED <<<-----------------------
explore: inventory_items {
  sql_always_where: ${created_date} >= '2019-01-01' ;;
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  persist_with: orders_datagroup
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}


#-------->>> 'ALWAYS_FILTER' FILTER APPLIED  <<<-----------------------
explore: products {
  always_filter: {
    filters: {
      field: distribution_centers.name
      value: "Chicago IL"
    }
  }
  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}
