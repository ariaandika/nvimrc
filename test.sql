



SELECT o.* FROM orders o
LEFT JOIN users_snapshot u ON u.snapshot_id = o.order_id;




