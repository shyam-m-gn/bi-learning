view: inventory_items {
  sql_table_name: PUBLIC.INVENTORY_ITEMS ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}."COST" ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}."PRODUCT_BRAND" ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}."PRODUCT_CATEGORY" ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}."PRODUCT_DEPARTMENT" ;;
  }

  dimension: product_distribution_center_id {
    type: number
    sql: ${TABLE}."PRODUCT_DISTRIBUTION_CENTER_ID" ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."PRODUCT_ID" ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}."PRODUCT_NAME" ;;
  }

  dimension: product_retail_price {
    type: number
    sql: ${TABLE}."PRODUCT_RETAIL_PRICE" ;;
  }

 #-------------------------------------->> DIMESION WITH TYPE NUMBER <<-------------------------------------------
 dimension: product_discount_price{
   type: number
  sql: ${product_retail_price}*0.10 ;;
 }
  dimension: product_sku {
    type: string
    sql: ${TABLE}."PRODUCT_SKU" ;;
  }

  dimension_group: sold {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SOLD_AT" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, product_name, products.id, products.name, order_items.count]
  }

  #-------------------------------------->> MEASURE WITH TYPE SUM <<-------------------------------------------
  #-------------------------------------->> DRILL PATH DEFINED<<-------------------------------------------

  measure: Total_Inventory_Cost{
    type:  sum
    sql: ${cost} ;;
    drill_fields: [product_name, order_items.count]
  }

  #-------------------------------------->> FILTERED MEASURE 1 <<-------------------------------------------
  #-------------------------------------->> DRILL PATH DEFINED<<-------------------------------------------

  measure: Total_Inventory_Cost_by_Men {
    type: sum
    sql: ${cost} ;;
    filters: {
      field: product_department
      value: "Men"
    }
    drill_fields: [product_name, order_items.count]
  }

  #-------------------------------------->> FILTERED MEASURE 2 <<-------------------------------------------
  #-------------------------------------->> DRILL PATH DEFINED<<-------------------------------------------

  measure: Total_Inventory_Cost_by_Women {
    type: sum
    sql: ${cost} ;;
    filters: {
      field: product_department
      value: "Women"
    }
    drill_fields: [product_name, order_items.count]
  }
  #-------------------------------------->>  MEASURE REFERENCEING OTHER MEASURES <<-------------------------------------------
  #-------------------------------------->> DESCRIPTION ADDED <<-------------------------------------------
  #-------------------------------------->> VALUE FORMAT ADDED <<-------------------------------------------

  measure: percent_inventory_cost_men {
    description: "% Cost by Men"
    type: number
    sql: ${Total_Inventory_Cost_by_Men}/${Total_Inventory_Cost} ;;
    value_format_name: percent_2
  }

  }
