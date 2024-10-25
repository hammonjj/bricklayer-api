# Random Notes
Lego URL Format:
https://www.lego.com/en-us/product/75313
https://www.lego.com/en-us/product/75397

## Rebrickable API:
API Call: `get /api/v3/lego/sets/{set_num}/ `
Note that the set has a suffix of `-1`

```json
{
  "set_num": "75313-1",
  "name": "AT-AT",
  "year": 2021,
  "theme_id": 171,
  "num_parts": 6785,
  "set_img_url": "https://cdn.rebrickable.com/media/sets/75313-1/94568.jpg",
  "set_url": "https://rebrickable.com/sets/75313-1/at-at/",
  "last_modified_dt": "2021-11-11T03:14:33.366360Z"
}
```