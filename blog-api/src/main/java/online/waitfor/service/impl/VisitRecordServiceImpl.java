package online.waitfor.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import online.waitfor.entity.VisitRecord;
import online.waitfor.mapper.VisitRecordMapper;
import online.waitfor.service.VisitRecordService;

/**
 * @Description: 访问记录业务层实现
 * @Author: Naccl
 * @Date: 2021-02-23
 */
@Service
public class VisitRecordServiceImpl implements VisitRecordService {
	@Autowired
	VisitRecordMapper visitRecordMapper;

	@Transactional(rollbackFor = Exception.class)
	@Override
	public void saveVisitRecord(VisitRecord visitRecord) {
		visitRecordMapper.saveVisitRecord(visitRecord);
	}
}
