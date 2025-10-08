SELECT
    m.rolname as member,
    r.rolname as role,
    admin_option
FROM pg_auth_members am
JOIN pg_roles r ON r.oid = am.roleid
JOIN pg_roles m ON m.oid = am.member
WHERE m.rolname = 'aaevstegneev';
