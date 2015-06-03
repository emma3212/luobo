package com.luobo.service.login;

import com.pandawork.core.exception.SSException;
import org.apache.shiro.subject.Subject;

/**
 * TGT的存储仓库
 * Created by Lionel on 2014/5/30.
 */
public interface SubjectStore {

	/**
	 * 查找TGT
	 * @param key
	 * @return
	 * @throws com.pandawork.core.exception.SSException
	 */
	public Subject querySubject(String key)  throws SSException;

	/**
	 * 保存T票
	 * @param key
	 * @param value
	 * @return
	 * @throws com.pandawork.core.exception.SSException
	 */
	public Subject addTGT(String key, Subject value) throws  SSException;

	/**
	 * 移除TGT
	 *
	 * @param key
	 * @return
	 * @throws com.pandawork.core.exception.SSException
	 */
	public Subject delTGT(String key) throws  SSException;
}
