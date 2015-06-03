package com.luobo.service.login.impl;

import com.ebiz.base.util.Assert;
import com.luobo.common.exception.LuoboException;
import com.luobo.service.login.SubjectStore;
import com.pandawork.core.exception.SSException;
import org.apache.shiro.subject.Subject;

import java.util.LinkedHashMap;
import java.util.Map;

public class SujectStorDefaultImpl implements SubjectStore {
	// 缓存
	//private Map<String, Subject> tgtCached = new ConcurrentHashMap<String, Subject>();

    private static final float hashTableLoadFactor = 0.75f;

    private static LinkedHashMap<String, Subject> tgtCached;
    private static final int DEFAULT_CACHE_SIZE = 10000;

    static {
        int hashTableCapacity = (int) Math.ceil(DEFAULT_CACHE_SIZE / hashTableLoadFactor) + 1;
        tgtCached = new LinkedHashMap<String, Subject>(hashTableCapacity, hashTableLoadFactor, true) {
            // (an anonymous inner class)
            private static final long serialVersionUID = 1;

            @Override
            protected boolean removeEldestEntry(Map.Entry<String, Subject> eldest) {
                return size() > DEFAULT_CACHE_SIZE;
            }
        };
    }


	@Override
	public synchronized Subject querySubject(String key) throws SSException {
		Assert.isNotNull(key, LuoboException.SecurityTGTKeyNotnull);  // key不能为空
		return tgtCached.get(key);
	}

	@Override
	public synchronized Subject addTGT(String key, Subject value) throws SSException {
		Assert.isNotNull(key, LuoboException.SecurityTGTKeyNotnull);  // key不能为空
		Assert.isNotNull(value, LuoboException.SecurityTGTValueNotnull);  // key不能为空

		return tgtCached.put(key, value);
	}

	@Override
	public synchronized Subject delTGT(String key) throws  SSException {
		if(Assert.isNull(key)){
			return null;
		}
		return tgtCached.remove(key);
	}
}
