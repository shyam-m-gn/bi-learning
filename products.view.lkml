view: products {
  sql_table_name: PUBLIC.PRODUCTS ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}."BRAND" ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}."CATEGORY" ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}."COST" ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}."DEPARTMENT" ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."DISTRIBUTION_CENTER_ID" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}."RETAIL_PRICE" ;;
  }

  #-------------------------------------->> DIMENSION WITH TYPE TIER <<-------------------------------------------
#-------------------------------------->> TIER - DRILL PATH DEFINED<<-------------------------------------------

dimension: price_tier {
  type: tier
  tiers: [50,100,200,500]
  style: integer
  sql: ${retail_price} ;;
  drill_fields: [name]
}

#-------------------------------------->> DIMENSION WITH TYPE YES/NO <<------------------------------------------
#-------------------------------------->> DESCRIPTION ADDED <<-------------------------------------------

dimension: luxury_item_flag {
  description: "Yes means product retail price is above $500"
  type: yesno
  sql: ${retail_price}>500 ;;
}
  dimension: sku {
    type: string
    sql: ${TABLE}."SKU" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.id, distribution_centers.name, inventory_items.count]
  }
}
