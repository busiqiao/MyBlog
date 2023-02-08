package online.waitfor.util.upload.channel;

import online.waitfor.config.properties.BlogProperties;
import online.waitfor.config.properties.UploadProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;
import online.waitfor.util.upload.UploadUtils;

import java.io.File;
import java.io.FileOutputStream;
import java.util.UUID;

/**
 * 本地存储方式
 *
 * @author: Waitfor
 * @date: 2023-02-11
 */
@Lazy
@Component
public class LocalChannel implements FileUploadChannel {
    @Autowired
    private BlogProperties blogProperties;
    @Autowired
    private UploadProperties uploadProperties;

    /**
     * 将图片保存到本地，并返回访问本地图片的URL
     *
     * @param image 需要保存的图片
     * @return 访问图片的URL
     * @throws Exception
     */
    @Override
    public String upload(UploadUtils.ImageResource image) throws Exception {
        File folder = new File(uploadProperties.getPath());
        if (!folder.exists()) {
            System.out.println("不存在次路径，开始创建");
            if (folder.mkdirs()) {
                System.out.println("路径创建成功");
            } else {
                System.out.println("路径创建失败");
            }
        }
        String fileName = UUID.randomUUID() + "." + image.getType();
        FileOutputStream fileOutputStream = new FileOutputStream(uploadProperties.getPath() + fileName);
        fileOutputStream.write(image.getData());
        fileOutputStream.close();
//        System.out.println(blogProperties.getApi() + "/image/" + fileName);
        return blogProperties.getApi() + "/image/" + fileName;
//		bug
    }
}
