- dashboard: sm_dashboard
  title: SM_Dashboard
  layout: newspaper
  elements:
  - title: MEN's Products
    name: MEN's Products
    model: shyammohan_thelook
    explore: products
    type: looker_pie
    fields: [products.count, distribution_centers.name]
    filters:
      distribution_centers.name: ''
      products.department: Men
    sorts: [products.count desc]
    limit: 500
    value_labels: labels
    label_type: labPer
    inner_radius: 60
    color_application:
      collection_id: 9d1da669-a6b4-4a4f-8519-3ea8723b79b5
      palette_id: 0c5264fb-0681-4817-b9a5-d3c81002ce4c
      options:
        steps: 5
    series_types: {}
    listen: {}
    row: 2
    col: 3
    width: 20
    height: 6
  - title: WOMEN's Products
    name: WOMEN's Products
    model: shyammohan_thelook
    explore: products
    type: looker_pie
    fields: [products.count, distribution_centers.name]
    filters:
      distribution_centers.name: ''
      products.department: Women
    sorts: [products.count desc]
    limit: 500
    value_labels: labels
    label_type: labPer
    inner_radius: 60
    color_application:
      collection_id: 9d1da669-a6b4-4a4f-8519-3ea8723b79b5
      palette_id: 0c5264fb-0681-4817-b9a5-d3c81002ce4c
      options:
        steps: 5
    series_types: {}
    listen: {}
    row: 8
    col: 3
    width: 20
    height: 6
  - name: MENS & WOMENS PRODUCT INVENTORY BY DISTRIBUTION CENTER
    type: text
    title_text: MENS & WOMENS PRODUCT INVENTORY BY DISTRIBUTION CENTER
    body_text: ''
    row: 0
    col: 3
    width: 20
    height: 2
