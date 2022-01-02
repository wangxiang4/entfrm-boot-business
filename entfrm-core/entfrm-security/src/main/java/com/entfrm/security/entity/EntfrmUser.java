package com.entfrm.security.entity;

import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author yong
 * @date 2020/3/10
 *
 * 扩展用户信息
 */
public class EntfrmUser extends User {
	/**
	 * 用户ID
	 */
	@Getter
	private Integer id;
	/**
	 * 部门ID
	 */
	@Getter
	private Integer deptId;
	/**
	 * 角色关联
	 */
	private List<String> roleIds;

	public EntfrmUser(Integer id, Integer deptId, String username, String password,List<String> roleIds,boolean enabled, boolean accountNonExpired, boolean credentialsNonExpired, boolean accountNonLocked, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		this.id = id;
		this.deptId = deptId;
		this.roleIds = roleIds;
	}

	public boolean isAdmin() {
		return isAdmin(this.id);
	}

	public static boolean isAdmin(Integer id) {
		return id != null && 1 == id;
	}

	public String getRoleIds() {
		return roleIds.stream().collect(Collectors.joining(","));
	}
}
