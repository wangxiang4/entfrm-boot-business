import com.entfrm.web.WebApplication;
import org.flowable.engine.ProcessEngineConfiguration;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 单元测试
 * </p>
 *
 * @Author: anonymous
 * @Date: 2021/2/9
 */
@RunWith(SpringJUnit4ClassRunner.class)//初始化spring上下文
@SpringBootTest(classes = WebApplication.class,webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class WebApplicationTest {


    @Autowired
    ProcessEngineConfiguration engineConfiguration;


    @Test
    @Transactional
    @Rollback(false)
    public void demo() throws Exception {
        engineConfiguration.buildProcessEngine();
    }


}
