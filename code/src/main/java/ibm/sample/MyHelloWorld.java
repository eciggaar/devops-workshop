package ibm.sample;

import io.vertx.reactivex.core.AbstractVerticle;
import io.vertx.reactivex.core.Vertx;

public class MyHelloWorld extends AbstractVerticle {

    @Override
    public void start() {
        // TODO: set a timer and do something such as print a string periodically
    }

    public static void main(String[] args){
        Vertx.vertx().deployVerticle(MyHelloWorld.class.getName());
    }
}
