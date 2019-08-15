view: order_items {
  sql_table_name: PUBLIC.ORDER_ITEMS ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
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

  dimension_group: delivered {
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
    sql: ${TABLE}."DELIVERED_AT" ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}."ORDER_ID" ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}."RETURNED_AT" ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}."SALE_PRICE" ;;
  }

  dimension_group: shipped {
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
    sql: ${TABLE}."SHIPPED_AT" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

#-------------------------------------->> DIMENSION WITH TYPE CASE <<-------------------------------------------
#-------------------------------------->> DESCRIPTION ADDED <<-------------------------------------------

  dimension: fulfilment_status {
    description: "OPEN orders vs CLOSED orders"
     case: {
      when: {
        sql: ${status}='Processing' ;;
        label: "OPEN"
      }
      when: {
        sql:${status}='Shipped' ;;
        label: "OPEN"
      }
      when: {
        sql:${status}='Returned' ;;
        label: "OPEN"
      }
      else: "CLOSED"
    }
  }
  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  #-------------------------------------->> MEASURE WITH TYPE MIN <<-------------------------------------------
  #-------------------------------------->> DRILL PATH DEFINED<<-------------------------------------------

  measure: minimum_sales_price{
    description: "Minimum sales price of a product"
    type:  min
    sql: ${sale_price} ;;
    value_format_name: usd
    drill_fields: [detail*]
  }
  #-------------------------------------->> MEASURE WITH TYPE MAX <<-------------------------------------------
  #-------------------------------------->> DRILL PATH DEFINED<<-------------------------------------------
  #-------------------------------------->> DESCRIPTION ADDED <<-------------------------------------------

  measure: maximum_sales_price{
    description: "maximum sales price of a product"
    type:  max
    sql: ${sale_price} ;;
    value_format_name: usd
    drill_fields: [detail*]
  }
  #-------------------------------------->> MEASURE WITH TYPE AVERAGE <<-------------------------------------------
  #-------------------------------------->> DESCRIPTION ADDED <<-------------------------------------------

  measure: average_sales_price{
    description: "Average sales price of a product"
    type:  average
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  #-------------------------------------->> VALUE FORMAT DEFINED <<-----------------------------------
  measure: total_sales {
    type: sum
    sql: ${sale_price}  ;;
    value_format_name: usd_0
  }

#---------------------------->> MEASURE that references a field from another view <<------------------------------
#-------------------------------------->> DRILL PATH DEFINED<<-------------------------------------------
#-------------------------------------->> DESCRIPTION ADDED <<-------------------------------------------

measure: total_orders_by_US_customers {
  description: "Number of Orders placed by Customer in US "
  type: count_distinct
  sql: ${order_id} ;;
  filters: {
    field: users.country
    value: "USA"
  }
  drill_fields: [users.first_name,users.last_name]
}
  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}
